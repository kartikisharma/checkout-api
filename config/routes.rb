Rails.application.routes.draw do
 resources :items, param: :barcode
end
