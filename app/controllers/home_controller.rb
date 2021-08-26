# frozen_string_literal: true

# Home Controller
class HomeController
  def index
    [
      200,
      { 'Content-Type' => 'text/plain' },
      ['Hello, you\'re at the Home page.']
    ]
  end
end
