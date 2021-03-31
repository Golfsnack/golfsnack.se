# frozen_string_literal: true

namespace :courses do
  desc 'Import courses from golfguide'
  task fetch: :environment do
    # http://golfguide.golfbox.dk/APIS/ScriptHandler.ashx?methodName=GolfSe_GetClubs
    # http://golfguide.golfbox.dk/APIS/ScriptHandler.ashx?methodName=GetClub&guid=72290d5e-b809-4cbf-89e3-38f831b482e6

    class Cache
      def initialize
        @client = Dalli::Client.new
      end

      def clear
        @client.flush_all
      end

      def get(request)
        @client.get(request.cache_key)
      end

      def set(request, response)
        @client.set(request.cache_key, response)
      end
    end
    # Cache.new.clear #sometimes, stuff works in mysterious ways

    Typhoeus::Config.cache = Cache.new
    Typhoeus::Config.memoize = true

    hydra = Typhoeus::Hydra.new(max_concurrency: 1000)
    puts '- STARTING ---------------------------------------------------------------'

    courses_json = open('http://golfguide.golfbox.dk/APIS/ScriptHandler.ashx?methodName=GolfSe_GetClubs').read
    File.open('_data/golfclubs.json', 'w+') do |f|
      f.write(courses_json)
    end

    courses = JSON.parse(courses_json)

    courses.each do |course|
      guid = course['GUID']

      course_json = open("http://golfguide.golfbox.dk/APIS/ScriptHandler.ashx?methodName=GetClub&guid=#{guid}").read
      File.open("_data/courses/#{guid}.json", 'w+') do |f|
        f.write(course_json)
      end
      c = JSON.parse(course_json)
      puts c.inspect
    end

    hydra.run
    puts '- FINISHED ------------------------------------------------------------------------'
  end

  desc 'Import courses from json files in _data'
  task import: :environment do
    Dir['_data/courses/*.json'].each do |file|
      data = JSON.parse(File.read(file))

      next if data['Data']['Courses'].nil?

      lat = data['MapLat']
      lng = data['MapLng']
      guid = data['GUID']
      club_name = data['Name']
      note = data['Data']['Note']

      club = Club.create(import_guid: guid, name: club_name, lat: lat, lng: lng, description: note)

      data['Data']['Courses'].each do |c|
        name        = c['Name']
        holes_count = c['NumberOfHoles']
        par         = c['Par']
        desc        = c['Note']
        architect   = c['Architect']

        course = Course.create(
          club: club,
          name: name,
          holes_count: holes_count,
          par: par,
          description: desc,
          architect: architect
        )

        c['Loop']['Holes'].each do |h|
          number            = h['Number']
          par               = h['Par']
          index             = h['Index']

          hole = Hole.create(course: course, number: number, par: par, index: index)
        end
      end
    end
  end
end
