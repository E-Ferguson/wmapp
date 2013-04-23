ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  #uses older dashboard style - will be deprecated in next version - remove line in active admin stylesheet when upgrading 

  ActiveAdmin::Dashboards.build do
  
  section "Resolved and Inactive Workorders" do
    table_for Workorder.where(:state => 'Resolved').find(:all, :conditions => ["updated_at < ?", 3.days.ago]) do |t| #shows resolved workorders that haven't been touched in at least 3 days
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      t.column("Worker") { |workorder| link_to Worker.where(:id => workorder.worker_id).first.name, admin_worker_path(workorder.user_id) }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| link_to "Close Workorder", admin_workorder_path(workorder.id) }
    end
  end


  section "Deferred Workorders" do
    table_for Workorder.where(:state => 'Deferred') do |t|
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      t.column("Worker") { |workorder| link_to Worker.where(:id => workorder.worker_id).first.name, admin_worker_path(workorder.user_id) }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| link_to "Re-assign Workorder", admin_workorder_path(workorder.id) }
    end
  end



  section "Worker Stats" do
    table_for Worker.all do |t|
            t.column("Name") { |worker| link_to worker.name, admin_worker_path(worker.id) }
            t.column("Number of Currently Assigned Workorders") { |worker| Workorder.where(:worker_id => worker.id, :state => "Assigned").size + Workorder.where(:worker_id => worker.id, :state => "In Progress").size }
            t.column("Workorders Completed in Last Month") { |worker| Workorder.where(:worker_id => worker.id, :state => "Resolved").size + Workorder.where(:worker_id => worker.id, :state => "Closed").find(:all, :conditions => ["created_at > ?", 30.days.ago]).size }
            t.column("Workorders Reopened in Last Month") {|worker| Worklog.where(:worker_id => worker.id, :state => "Reopened").find(:all, :conditions => ["created_at > ?", 30.days.ago]).size }
    end #end table
  end 

  section "Unassigned Workorders" do
    table_for Workorder.where(:state => 'Pending') do |t|
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      #t.column("Workers") { :collection => Worker.all.map(&:name) }
      t.column("Assignment") { |workorder| link_to "Assign Workorder", admin_workorder_path(workorder.id) }
    end
  end

  section "Reopened" do #Not high priority for admins, but if they see the same workorder reopen several times, they can reassign it to someone else 
    table_for Workorder.where(:state => 'Reopened') do |t|
      t.column("Updated") { |workorder| time_ago_in_words(workorder.updated_at)+" ago" }
      t.column("User") { |workorder| link_to User.where(:id => workorder.user_id).first.name, admin_user_path(workorder.user_id) }
      t.column("Email") { |workorder| User.where(:id => workorder.user_id).first.email }
      t.column("Phone") { |workorder| User.where(:id => workorder.user_id).first.phone }
      t.column("Building") { |workorder| workorder.building }
      t.column("Room Number") { |workorder| workorder.room }
      t.column("Description") { |workorder| workorder.description }
      t.column("Assignment") { |workorder| link_to "Re-assign Workorder", admin_workorder_path(workorder.id) }
    end
  end

  section "Recent High Priority Comments/Updates" do 
    table_for Worklog.where(:unsolicited => true).find(:all, :conditions => ["created_at > ?", 7.days.ago]) do |t|
      t.column("Created") { |worklog| time_ago_in_words(worklog.created_at)+" ago" }
      t.column("Workorder Last Updated") { |worklog| time_ago_in_words(worklog.workorder.updated_at)+" ago" }
      t.column("Author") { |worklog| worklog.name }
      t.column("User Email") { |worklog| User.where(:id => worklog.workorder.user_id).first.email }
      t.column("User Phone") { |worklog| User.where(:id => worklog.workorder.user_id).first.phone }
      t.column("Building") { |worklog| worklog.workorder.building }
      t.column("Room Number") { |worklog| worklog.workorder.room }
      t.column("Workorder Description") { |worklog| worklog.workorder.description }
      t.column("Comment/Update") { |worklog| worklog.description }
      t.column("Reply and Keep High Priority") { |worklog| link_to "Reply", respond_to_comment_path(worklog.workorder.id, worklog.id) }
      t.column("Reply and Mark as Low Priority") { |worklog| link_to "Reply and Mark as Low Priority", respond_to_comment_path(worklog.workorder.id, worklog.id) }
      #placeholder for columns
    end
  end

end



  #show deferred workorders

  #show workorders assigned to each worker 

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

end
