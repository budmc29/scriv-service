require 'grape'

module Database
  class Ideas
    def self.all
      [
        { id: 1,
          title: 'title 1',
          description: 'description 1'
        },
        { id: 2,
          title: 'title 2',
          description: 'description 2'
        }
      ]
    end

    def self.find(id)
      "Idea with id: #{id}"
    end
  end
end

module ScrivService
  class API < Grape::API
    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api

    resource :ideas do
      desc 'Return all ideas'
      get do
        Database::Ideas.all
      end

      desc 'Return an idea'
      params do
        requires :id, type: Integer, desc: 'Idea id.'
      end
      route_param :id do
        get do
          Database::Ideas.find(params[:id])
        end
      end
    end
  end
end

run ScrivService::API
