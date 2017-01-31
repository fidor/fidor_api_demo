module ControllersHelper
  def namespace?(*controller)
    controller.include?(params[:controller].split("/").first)
  end
end
