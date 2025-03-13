#app/controller/scraper_controller.rb
class ScrapersController
  def scrape
    # Get the Idealista URL from the request parameters
    idealista_url = params[:url]

    # Initialize the Apify client with your API token
    client = Apify::Client.new(api_token: 'apify_api_sIKYUDOil7IbF9b0kzn4ftoRNFgtjM1DcJld')

    # Start a new run of the Idealista scraper actor with the provided URL
    run = client.actor('YOUR_IDEALISTA_SCRAPER_ACTOR_ID').start(run_input: { startUrls: [{ url: idealista_url }] })

    # Wait for the run to finish
    client.wait_for_run(run_id: run['id'])

    # Fetch the scraped data from the dataset
    dataset = client.dataset(run['defaultDatasetId'])
    results = dataset.list_items

    # Extract the relevant property details from the scraped data
    property_data = results.first
    property = Property.new(
      name: property_data['name'],
      address: property_data['address'],
      typology: property_data['typology'],
      garage: property_data['garage'],
      elevator: property_data['elevator'],
      size: property_data['size'],
      price: property_data['price'],
      url: property_data['url'],
      collection: current_user.collections.first # Assign the property to the user's first collection
    )

    if property.save
      # Display the scraped property details to the user or perform any additional actions
      redirect_to property_path(property), notice: 'Property scraped and saved successfully.'
    else
      # Handle the case when saving the property fails
      redirect_to root_path, alert: 'Failed to save the scraped property.'
    end
  end
end
