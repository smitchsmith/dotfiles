require 'oauth'
require 'yaml'
require 'launchy'
require 'secrets'

class TwitterSession

  CONSUMER_KEY = Secrets::CONSUMER_KEY
  CONSUMER_SECRET = Secrets::CONSUMER_SECRET

  # Both `::get` and `::post` should return the parsed JSON body.
  def self.get(path, query_values = nil)
    self.access_token
    .get(path_to_url(path, query_values))
    .body
  end

  def self.post(path, req_params)
    self.access_token
    .post(path_to_url(path, req_params))
    .body
  end

  TOKEN_FILE = "access_token.yml"

  def self.access_token
    # Load from file or request from Twitter as necessary. Store token
    # in class instance variable so it is repeatedly re-read from disk
    # unnecessarily.

    # We can serialize token to a file, so that future requests don't
    # need to be reauthorized.
    if @access_token.nil?
      if File.exist?(TOKEN_FILE)
        # reload token from file
        @access_token = File.open(TOKEN_FILE) { |f| YAML.load(f) }
      else
        # copy the old code that requested the access token into a
        # `request_access_token` method.
        access_token = request_access_token
        File.open(TOKEN_FILE, "w") { |f| YAML.dump(access_token, f) }

        @access_token = access_token
      end
    end
    @access_token
  end

  def self.request_access_token
    # Put user through authorization flow; save access token to file
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")
    request_token = consumer.get_request_token
    authorize_url = request_token.authorize_url

    puts "Go to this URL: #{authorize_url}"
    Launchy.open(authorize_url)

    puts "Login, and type your verification code in"
    oauth_verifier = gets.chomp
    access_token = request_token.get_access_token(
      :oauth_verifier => oauth_verifier
    )

    access_token
  end

  def self.path_to_url(path, query_values = nil)
    # All Twitter API calls are of the format
    # "https://api.twitter.com/1.1/#{path}.json". Use
    # `Addressable::URI` to build the full URL from just the
    # meaningful part of the path (`statuses/user_timeline`)

    query = Addressable::URI.new(
      :scheme => "https",
      :host => "api.twitter.com",
      :path => "1.1/#{path}.json",
      :query_values => query_values
    ).to_s

  end


end
