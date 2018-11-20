require 'zendesk_api'

$client = ZendeskAPI::Client.new do |config|

    # Mandatory:
    config.url = "https://rocketelevatorsluna.zendesk.com/api/v2"

    # Basic / Token Authentication
    config.username = "victorialeclerc42@gmail.com"

    # Choose one of the following depending on your authentication choice
    config.token = ENV['ZenDesk']
    # config.password = ENV['ZenDesk']

    # OAuth Authentication
    # config.access_token = "b594a15231ec57f666992ae64f259f41db8476e65eb6a0a84d70108dd24b6a8d"

    # Optional:

    # Retry uses middleware to notify the user
    # when hitting the rate limit, sleep automatically,
    # then retry the request.
    config.retry = true

    # Logger prints to STDERR by default, to e.g. print to stdout:
    require 'logger'
    config.logger = Logger.new(STDOUT)

    # Changes Faraday adapter
    # config.adapter = :patron

    # Merged with the default client options hash
    # config.client_options = { :ssl => false }

    # When getting the error 'hostname does not match the server certificate'
    # use the API at https://yoursubdomain.zendesk.com/api/v2

end