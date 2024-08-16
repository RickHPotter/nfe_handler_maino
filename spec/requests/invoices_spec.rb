# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/invoices", type: :request do
  let!(:user) { create(:user, :random) }
  let!(:invoice) { create(:invoice, :one) }
  let(:xml_file_one) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "001.xml"), "application/xml") }
  let(:xml_file_two) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "002.xml"), "application/xml") }
  let(:zip_file) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "zip.zip"), "application/zip") }
  let(:unsupported_file) { fixture_file_upload(Rails.root.join("public", "spec", "assets", "unsupported.txt"), "text/plain") }

  before { sign_in user }

  def expect_document_to_be_created_and_job_to_be_enqueued
    expect(Document.last).not_to be_nil
    expect(Xml::ProcessingJob).to have_been_enqueued.with(Document.last.id, user)

    expect(response).to redirect_to(invoices_url)
    expect(flash[:notice]).to eq(I18n.t("invoices.create.success"))
  end

  describe "GET /index" do
    it "renders a successful response" do
      get invoices_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get invoice_url(invoice)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_invoice_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "processes XML file and enqueues Xml::ProcessingJob for it" do
        [ xml_file_one, xml_file_two ].each do |file|
          expect do
            post invoices_path, params: { invoice: { file: } }
          end.to change(Document, :count).by(1)

          expect_document_to_be_created_and_job_to_be_enqueued
        end
      end

      it "processes ZIP file and enqueues Xml::ProcessingJob for each XML inside" do
        expect do
          post invoices_path, params: { invoice: { file: zip_file } }
        end.to change(Document, :count).by(1)

        expect_document_to_be_created_and_job_to_be_enqueued
      end
    end

    context "with invalid parameters" do
      it "does not process unsupported type file and does no enqueue Job" do
        expect do
          post invoices_path, params: { invoice: { file: unsupported_file } }
        end.to change(Document, :count).by(0)
      end

      it "redirects to :new again with alert notification" do
        post invoices_path, params: { invoice: { file: unsupported_file } }
        expect(response).to redirect_to(new_invoice_url)
        expect(flash[:alert]).to eq(I18n.t("invoices.create.failure"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested invoice" do
      expect do
        delete invoice_url(invoice)
      end.to change(Invoice, :count).by(-1)
    end

    it "redirects to the invoices list" do
      delete invoice_url(invoice)
      expect(response).to redirect_to(invoices_url)
    end
  end
end
