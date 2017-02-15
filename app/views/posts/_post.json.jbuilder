json.extract! post, :id, :host_name, :host_email, :numgsts, :guest_names, :venue, :location, :theme, :when, :when_its_over, :descript, :created_at, :updated_at
json.url post_url(post, format: :json)