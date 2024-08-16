# SUMMARY

<!--toc:start-->
- [SUMMARY](#summary)
  - [INTRODUCTION](#introduction)
  - [TASKS](#tasks)
    - [001: Authentication](#001-authentication)
    - [002: Invoice Upload Screen](#002-invoice-upload-screen)
    - [003: Invoice Extraction Service/Job](#003-invoice-extraction-servicejob)
    - [004: Invoice Reports Screen](#004-invoice-reports-screen)
    - [005: Filters Addition to Invoice Report Screen](#005-filters-addition-to-invoice-report-screen)
<!--toc:end-->

## INTRODUCTION

The creation of this app ...

## TASKS

### 001: Authentication

- Subtasks:
  - ✅  Setup `Devise` for Authentication and `Letter Opener`.
  - ✅  Create User `Devise` model with `first_name` and `last_name`.
  - ✅  Customise `Devise` Views for Sign Up and Log In.
  - ✅  Create components through helper views [TextField, Button].
  - ✅  Setup `RSpec` with `Faker` and `DatabaseCleaner`.
  - ✅  Create factory and spec for User model.
  - ✅  Enable test coverage through `Simplecov`.

- Extra:
  - ✅  Setup `HotwireLivereload` for development environment for hot_reload dev experience.
  - ✅  Setup `Bullet` in dev and test environments.
  - ✅  Setup `CI` for linting, checking for vulnerabilities, and testing.
  - ✅  Setup `Rubocop` and `ErbLint`.

### 002: Invoice Upload Screen

- Subtasks:
  - ✅ Create partial CRUD for `Invoice`.
  - ✅ Create `Invoice` model -> [cUF, cNF, mod, serie, nNF, dhEmi, tpNF, emit_id, dest_id]
  - ✅ Create `InvoiceEntity` model -> [CNPJ, xNome, xFant, IE, CRT, indIEDest, ender_id]
  - ✅ Create `EntityAddress` model -> [xLgr, nro, xCpl, xBairro, cMun, xMun, UF, CEP, cPais, xPais, fone]
  - ✅ Setup form for uploading a single invoice of type `xml`.

- Extra:
  - ✅ Setup form for uploading a `zip` file that contains multiple invoices.
  - ✅ Implement file-input stimulus controller for file upload and drag-and-drop.
  - ✅ Use notification stimulus controller from stimulus_components.

### 003: Invoice Extraction Service/Job

- Subtasks:
  - ✅ Create `Zip::XmlExtractionService` that processes `zip` files.
  - ✅ Create `Xml::NfeExtractionService` that processes `XML`s.
  - ✅ Create `Nfe::InvoiceService` that processes `Invoice`s.
  - ✅ Create a `Sidekiq` `Xml::ProcessingJob` for the `XmlExtractionService` Service.
  - ✅ Create a `Sidekiq` `Nfe::InvoiceJob` for the `InvoiceExtractionService` Service.
  - ✅ Fire `Nfe::InvoiceJob` as soon as `Xml::ProcessingJob` finishes processing an `xml`.

  - ⌛ Create models that revolve around with `Invoice` Structure.
    - 1 ⌛ `InvoiceItem` model -> [cProd, cEAN, xProd, NCM, CFOP, uCom, qCom, vUnCom, vProd, indTot]
    - 2 ⌛ `InvoiceItemTotal` model -> [vICMS, vIPI, VII, VIOF, vTotTrib]
    - 2 ⌛ `InvoiceTotal` model -> [vBC, vICMS, vIPI, VII, VIOF, vPIS, vCOFINS, vOutro, vNF, vTotTrib]

- Extra:
  - ✅ Create specs for the whole flow of Services.
  - ✅ Create specs for the job execution.

### 004: Invoice Reports Screen

- Subtasks:
  - ⌛ Create `Invoice::ReportService` that processes `Report`s.
  - ⌛ Create an `InvoiceReport` `Sidekiq` Job.
    - 1 ⌛ `Report` based on all invoices uploaded.
    - 2 ⌛ Provide `Report` download to user in `excel` format.
  - ⌛ The created `Report` should follow a given structure.
    - 1 ⌛ Dados da Nota Fiscal: Número de Série (serie), Número da Nota Fiscal (nNF), Data e Hora de Emissão (dhEmi), Dados do Emitente (emit) e do Destinatário (dest). 2 ⌛ Produtos Listados: Nome (xProd), NCM (NCM), CFOP (CFOP), Unidade Comercializada (uCom), Quantidade Comercializada (qCom), Valor Unitário (vUnCom).
    - 3 ⌛ Impostos Associados: Valor do ICMS (vICMS), Valor do IPI (vIPI), Valor do PIS (vPIS), Valor do COFINS (vCOFINS).
    - 4 ⌛ Totalizadores: Resumo dos valores totais dos produtos e impostos.

- Extra:
  - ⌛ Be.

### 005: Filters Addition to Invoice Report Screen

- Subtasks:
  - ⌛ Use TDD approach; create the tests before.

- Extra:
  - ⌛ Be.
