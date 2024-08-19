# frozen_string_literal: true

# Model Structure
#
# ├── User/
# │   └── Invoices
# └── Invoice/
#     ├── User
#     ├── Document
#     ├── InvoiceEntity (emit, dest)/
#     │   └── EntityAddress
#     ├── InvoiceItems
#     │   └── InvoiceItemTotal
#     └── InvoiceTotal

# FactoryBot.create(:user)
