module UsersHelper
    def authenticate_admin
        unless user_signed_in? && current_user.admin? || user_signed_in? && current_user.vip?
        redirect_to_dashboard_mains_path, alert: "You are not authorized to view this page"
    end
end