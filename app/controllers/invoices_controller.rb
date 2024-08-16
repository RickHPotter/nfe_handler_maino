# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show destroy]

  def index
    @invoices = Invoice.all
  end

  def show; end

  def new; end

  def create
    @document = Document.create(file:) if file_is_supported

    respond_to do |format|
      if @document&.persisted?
        Xml::ProcessingJob.perform_later(@document.id, current_user)

        format.html { redirect_to invoices_url, notice: I18n.t("invoices.create.success") }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { redirect_to new_invoice_url, alert: I18n.t("invoices.create.failure") }
        format.json { render :show, status: :unprocessable_entity, location: @invoice }
      end
    end
  end

  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: I18n.t("invoices.destroy.success") }
      format.json { head :no_content }
    end
  end

  private

  def file
    params[:invoice][:file]
  end

  def file_is_supported
    file&.content_type&.split("/")&.last&.in?(%w[xml zip])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_params
    params.require(:invoice).permit
  end
end
