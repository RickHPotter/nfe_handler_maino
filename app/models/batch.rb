# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id                 :bigint           not null, primary key
#  description        :string
#  total_invoices     :integer          not null
#  processed_invoices :integer          not null
#  finished           :boolean          default(FALSE), not null
#  user_id            :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Batch < ApplicationRecord
  # @extends ..................................................................
  # @includes .................................................................
  include Sortable

  # @security (i.e. attr_accessible) ..........................................
  # @relationships ............................................................
  belongs_to :user
  belongs_to :document, optional: true

  has_many :invoice_batches, dependent: :destroy
  has_many :invoices, through: :invoice_batches

  # @validations ..............................................................
  validates :total_invoices, :processed_invoices, presence: true
  validates :total_invoices, numericality: { greater_than: 0 }
  validates :processed_invoices, numericality: { greater_than_or_equal_to: 0 }

  # @callbacks ................................................................
  # @scopes ...................................................................
  scope :by_cnpj, lambda { |cnpj|
    return if cnpj.blank?

    joins(invoices: %i[emit dest])
      .where("invoice_entities.cNPJ = :cnpj", cnpj:)
      .or(
        joins(invoices: %i[emit dest])
          .where("invoice_entities.cNPJ = :cnpj", cnpj:)
      )
  }

  # Scope for filtering by x_nome
  scope :by_x_nome, lambda { |x_nome|
    return if x_nome.blank?

    joins(invoices: %i[emit dest])
      .where("invoice_entities.xNome ILIKE :x_nome", x_nome: "%#{x_nome}%")
      .or(
        joins(invoices: %i[emit dest])
          .where("invoice_entities.xNome ILIKE :x_nome", x_nome: "%#{x_nome}%")
      )
  }
  scope :by_c_uf, ->(c_uf) { joins(:invoices).where(invoice: { c_uf: }) if c_uf.present? }

  # @additional_config ........................................................
  # @class_methods ............................................................
  # @public_instance_methods ..................................................
  # @protected_instance_methods ...............................................
  # @private_instance_methods .................................................
end
