# frozen_string_literal: true

class CreateEntityAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :entity_addresses do |t|
      t.string :xLgr, null: false, limit: 60, comment: "xLgr: Logradouro."
      t.string :nro, null: false, limit: 60, comment: "nro: Número do endereço."
      t.string :xCpl, limit: 60, comment: "xCpl: Complemento do endereço."
      t.string :xBairro, null: false, limit: 60, comment: "xBairro: Bairro."
      t.string :cMun, null: false, limit: 7, comment: "cMun: Código do município (utiliza código IBGE)."
      t.string :xMun, null: false, limit: 60, comment: "xMun: Nome do município."
      t.string :uF, null: false, limit: 2, comment: "UF: Sigla da Unidade Federativa."
      t.string :cEP, null: false, limit: 8, comment: "CEP: Código de Endereçamento Postal."
      t.string :cPais, null: false, limit: 4, comment: "cPais: Código do país (utiliza código BACEN)."
      t.string :xPais, null: false, limit: 60, comment: "xPais: Nome do país."
      t.string :fone, limit: 14, comment: "fone: Telefone (DDD + número)."

      t.timestamps
    end
  end
end
