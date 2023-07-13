Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'pdfs/change', to: 'pdfs#change'
  post 'imp_pdfs/change', to: 'imp_pdfs#change'
  post 'need_pdfs/change', to: 'need_pdfs#change'
end
