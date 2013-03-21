def log_in
  visit '/login'
  fill_in 'Email', :with => 'jonstewart@email.wm.edu'
  fill_in 'Password', :with => 'dailyshow'
  click_button 'Log in'
end

def valid_emails
  %w[jake@email.wm.edu jonstewart@email.wm.edu tj@email.wm.edu]
end

def invalid_emails
  %w[jake@gmail.com willsmith oldie@wm.edu]
end

def valid_worker_emails
  %w[jake@wm.edu jonstewart@wm.edu tj@wm.edu]
end

def invalid_worker_emails
  %w[jake@gmail.com willsmith oldie@email.wm.edu]
end
