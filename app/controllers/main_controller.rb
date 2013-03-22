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
	if flash[:new_url].blank? and flash[:status].blank?
		@new_url = ""
		@status = 0
	
	elsif flash[:new_url].blank? and flash[:status] == 2
		@new_url = ""
		@status = 2
		@status_msg = "Failed: Please Enter a Valid URL"
	else
		@new_url = "pn.ee/" + flash[:new_url]
		@status = 1
		@status_msg = "Successful!"
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
    
	if url_validation(url_input) == true
		@new_url_record = Url.new(:url => url_input, :key => key, :visitor_ip => visitor_ip)
		@new_url_record.save
		flash[:new_url] = key
		flash[:status] = 1
		redirect_to root_url
	else
		flash[:status] = 2
		redirect_to root_url
	end
		
    
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
  
  def url_validation(url)
  
	uri = URI.parse(URI.encode(url.strip))
	begin
	  resp = uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
    rescue URI::InvalidURIError
      resp = false
	end
	
	return resp
	
  end
  
end
