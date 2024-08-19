# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy download_excel]

  def index
    @pagy, @reports = pagy Batch.all.where(user: current_user)
                                .by_cnpj(params[:cnpj])
                                .by_x_nome(params[:x_nome])
                                .by_c_uf(params[:c_uf])
                                .apply_sort(params)
  end

  def show
    @pagy_invoices, @invoices = pagy @report.invoices.includes(:emit, :dest)
    @pagy_invoice_items, @invoice_items = pagy InvoiceItem.where(invoice_id: @report.invoices).includes(:invoice_item_total)
    @invoice_total = InvoiceTotal.from_ids(@report.invoices.pluck(:id))

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new; end

  def create
    respond_to do |format|
      # Batch::ReportJob.perform_later(batch_params, current_user)

      format.html { redirect_to reports_url, notice: I18n.t("reports.create.success") }
      format.json { render :show, status: :created, location: @report }
    end
  end

  def destroy
    @report.destroy!

    respond_to do |format|
      format.html { redirect_to reports_url, notice: I18n.t("reports.destroy.success") }
      format.json { head :no_content }
    end
  end

  def download_excel
    @document = @report.document
    send_data(@document.file.download, filename: @document.file.filename.to_s, type: @document.file.content_type) and return if @document

    excel_report = Report::ExcelService.new(@report).generate

    send_data excel_report, filename: "invoices_report.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Batch.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def batch_params
    params.require(:batch).permit
  end
end
