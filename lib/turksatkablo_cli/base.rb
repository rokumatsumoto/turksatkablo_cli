require 'thor'

module TurksatkabloCli
    class Base < Thor
      include TurksatkabloCli::OnlineOperations::Helpers
      include Thor::Actions
    end
end
