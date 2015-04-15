include ApplicationHelper

def sign_in(user, options = {})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in 'sign_in_email', with: user.email
    fill_in 'sign_in_password', with: user.password
    click_button 'sign_in_sign_in'
  end
end
