ActiveAdmin.register RadioShow do
  permit_params :title, :guest, :date, :format, embeded_links_attributes: {}, attached_file_attributes: {}

  index do
    column :title do |q|
      link_to q.title, admin_radio_show_path(q)
    end
    column :guest
    column :date
    column :format
    column :attached_file do |q|
      link_to 'Download', q.attached_file.attachment.url if q.attached_file
    end
    actions
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs 'Details' do
      f.input :title
      f.input :guest
      f.input :date, start_year: 2000, end_year: Date.today.year + 1
      f.input :format, as: :select, collection: ['Signs of Life', 'Mediums & Messages', 'The Gathering', 'Medium Insights']
    end

    f.inputs "Recording", :for => [:attached_file, f.object.attached_file || AttachedFile.new] do |recording_form|
      recording_form.input :attachment, as: :file
    end

    f.inputs "Embedded Links" do
      f.has_many :embeded_links, allow_destroy: true do |embeded_link|
        embeded_link.input :title
        embeded_link.input :body
      end
    end

    f.actions
  end


  show do
    h2 radio_show.title
    div do
      h3 radio_show.guest
      h3 radio_show.date.to_s
      h3 radio_show.format
      link_to 'Download', radio_show.attached_file.attachment.url if radio_show.attached_file
    end

    table_for(radio_show.embeded_links) do
      column "Embeded Links" do |elink|
        elink.body.html_safe
      end
    end
  end

end
