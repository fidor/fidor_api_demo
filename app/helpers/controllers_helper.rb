module ControllersHelper
  def namespace?(*controller)
    controller.include?(params[:controller].split('/').first)
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def is_active?(link_path, return_class = "active")
    current_page?(link_path) ? return_class : nil
  end
end
