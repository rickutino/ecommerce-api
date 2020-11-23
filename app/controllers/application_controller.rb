class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller? #もしdevise_controllerから呼ばれていたら。。。

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation]) #第１引数に特定コントローラーアクションのみアクセスが可能、
  end                                                                                                     #第２引数にはどのカラムを扱えるか許可する。
end
