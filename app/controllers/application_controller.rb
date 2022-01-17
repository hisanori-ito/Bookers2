class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #def after_sign_in_path_for(resource)
    # ユーザーの詳細画面マイページへ設定する
  #end

  #def after_sign_out_path_for(resource)
    # 元々ルートだから要らない。あとで消す
  #end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
