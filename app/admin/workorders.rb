ActiveAdmin.register Workorder do
    controller { with_role :admin }  
    
   #scope :all
   scope :pending
   scope :in_progress
   scope :completed  
   
    batch_action :assign do |selection|
      Workorder.find(selection).each do |post|
        post.flag! :hot
      end
    end
  
    
end
