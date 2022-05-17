# frozen_string_literal: true

module DatabaseSeeds
  # Database Seeds Dummy
  class Dummy
    class << self
      def execute
        db = Database.new.connection

        return if db.execute('SELECT * FROM books').count.positive?

        books.each do |book|
          db.execute(
            "INSERT INTO books (name, author) VALUES('#{book[:name]}', '#{book[:author]}')"
          )
        end
      end

      def books
        [
          { name: '1984', author: 'George Orwell' },
          { name: 'Pride and Prejudice', author: 'Jane Austin' },
          { name: 'Dracula', author: 'Bram Stoker' }
        ]
      end
    end
  end
end
