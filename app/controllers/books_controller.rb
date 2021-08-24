# frozen_string_literal: true

# Books Controller
class BooksController
  def index
    [
      200,
      { 'Contend-Type' => 'text/plain' },
      [index_body]
    ]
  end

  private

  def index_body
    {
      1 => {
        name: '1984',
        author: 'George Orwell'
      },
      2 => {
        name: 'Pride and Prejudice',
        author: 'Jane Austin'
      },
      3 => {
        name: 'Dracula',
        author: 'Bram Stoker'
      }
    }.to_json
  end
end
