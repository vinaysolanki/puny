class MainController < ApplicationController
  def index
  
    @urls = Url.all
	@url_id = params[:id]
	@total_urls = Url.count
	@total_hits = total_views
	
	# Find long URL for corresponding key
	if @url_id != nil
		get_url = Url.find_by_key(@url_id)
		get_url.hits += 1
		get_url.save
		#@url_id_n = get_url.url
		redirect_to get_url.url
	end
	
	# Print shortened URL
	if params[:new_url].blank?
		@new_url = ""
		@status = 0
	else
		@new_url = "pn.ee/" + params[:new_url]
		@status = 1
    end
	
	
  end
  
  def shorten
  
    # Fetch Url
    url_input = params['url']
    
	# Fetch Ip
	visitor_ip = request.remote_ip
	
    # Generate a key
    key = generate_key
    
    # Keep generating a key until a unique is found
    while Url.exists?(:key => key)
      key = generate_key
    end
    
    @new_url_record = Url.new(:url => url_input, :key => key, :visitor_ip => visitor_ip)
    @new_url_record.save
    redirect_to root_url(:new_url => key)
    
  end
  
  def total_views
	
	total_hits = 0
	@all_url = Url.all
	@all_url.each do |u|
		if u.hits == nil
			hits = 0
		else
			hits = u.hits
		end
		total_hits += hits
	end
	
	return total_hits
	
  end
  
  def generate_key
  
    # Generate random string of length 5
    sample_array = ('a'..'z').to_a + ('1'..'9').to_a
    key_array = sample_array[rand(35)] + sample_array[rand(35)] + sample_array[rand(35)] + sample_array[rand(35)] + sample_array[rand(35)]
    key = key_array[0] + key_array[1] + key_array[2] + key_array[3] + key_array[4]
    return key
    
  end
end
