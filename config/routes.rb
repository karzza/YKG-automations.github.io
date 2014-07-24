Rails.application.routes.draw do

  root 'site#index'

  get 'About_Us'=> 'site#About_Us'
  get 'Contact_Us'=>'site#Contact_Us'
  get 'Products'=>'site#Products'
end
