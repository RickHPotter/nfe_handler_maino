# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]

  def index
    @invoices = Invoice.all
  end

  def show; end

  def new; end

  def edit; end

  def create
    case file.content_type.split("/").last
    when "xml"
      # xml_service = Xml::NfeExtractionService.new(file:)
      # nfe_service = Nfe::InvoiceService.new(xml_service, current_user)
      # nfe_service.run
      # Invoice::ReportService.run(nfe_service.invoice)
    when "zip"
      # zip_service = Zip::XmlExtractionService.new(file)
      # zip_service.extract_all_files
      # zip_service.xmls.each do |xml|
      #   xml_service = Xml::NfeExtractionService.new(xml:)
      #   nfe_service = Nfe::InvoiceService.new(xml_service, current_user)
      #   nfe_service.run
      #   Invoice::ReportService.run(nfe_service.invoice)
      # end
    end

    respond_to do |format|
      # if true
      format.html { redirect_to invoices_url, notice: "Invoice was successfully created." }
      format.json { render :show, status: :created, location: @invoice }
      # else
      #   format.html { render :new, status: :unprocessable_entity }
      #   format.json { render json: @invoice.errors, status: :unprocessable_entity }
      # end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit
  end

  def file
    params[:invoice][:file].last
  end
end
