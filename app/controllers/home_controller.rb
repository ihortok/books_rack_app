# frozen_string_literal: true

# Home Page Controller
class HomeController
  def index
    [
      200,
      { 'Contend-Type' => 'text/plain' },
      ['Hello, you\'re at the Home page.']
    ]
  end
end