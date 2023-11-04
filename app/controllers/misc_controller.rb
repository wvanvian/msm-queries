require 'time'

class MiscController < ApplicationController
  def homepage
    render({ :template => "misc_templates/home"})
  end

  def directors
    @directors = Director.where.not({ :dob => nil })
    render({ :template => "misc_templates/directors"})
  end

  def director
    @id = params.fetch("id").to_s
    if @id == "eldest"
      directors = Director.where.not({ :dob => nil })
      array = Array.new
      dob_hash = Hash.new
      
      directors.each do |a_director|
        array.append(a_director.dob)
        dob_hash[a_director.dob] = {:id => a_director.id, :name => a_director.name}
      end

      @id_number = dob_hash[array.min][:id]
      @name = dob_hash[array.min][:name]
      dob = array.min

      dob_str = dob.to_s
      dob_array = dob_str.split('-')

      date = Date.new(dob_array[0].to_i, dob_array[1].to_i, dob_array[2].to_i)
      @dob_format = date.strftime("%B %d, %Y")

      render({ :template => "misc_templates/eldest"})

    elsif @id == "youngest"
      directors = Director.where.not({ :dob => nil })
      array = Array.new
      dob_hash = Hash.new
      
      directors.each do |a_director|
        array.append(a_director.dob)
        dob_hash[a_director.dob] = {:id => a_director.id, :name => a_director.name}
      end

      @id_number = dob_hash[array.max][:id]
      @name = dob_hash[array.max][:name]
      dob = array.max

      dob_str = dob.to_s
      dob_array = dob_str.split('-')

      date = Date.new(dob_array[0].to_i, dob_array[1].to_i, dob_array[2].to_i)
      @dob_format = date.strftime("%B %d, %Y")

      render({ :template => "misc_templates/youngest"})

    else
      @director = Director.where({ :id => @id })[0]
      @movies = Movie.where({ :director_id => @director.id.to_i})

      render({ :template => "misc_templates/director"})
    end
  
  end

  def movies
    @movies = Movie.where.not({ :id => nil })

    @move_hash = Hash.new
    @movies.each do |a_movie|
      @move_hash[a_movie.id] = Director.where({ :id => a_movie.director_id.to_i })[0].name
    end

    render({ :template => "misc_templates/movies"})
  end

  def movie
    @id = params.fetch("id").to_i
    @movie = Movie.where({ :id => @id })[0]
    @director = Director.where({ :id => @movie.director_id.to_i })[0].name
    render({ :template => "misc_templates/movie"})
  end

  def actors
    @actors = Actor.where.not({ :dob => nil })
    render({ :template => "misc_templates/actors"})
  end

  def actor
    @id = params.fetch("id").to_i
    @actor = Actor.where({ :id => @id })[0]
    @characters = Character.where({:actor_id => @actor.id.to_i})
    
    @character_hash = Hash.new

    @characters.each do |a_character|
      @character_hash[a_character.id.to_i] = {
        :movie => Movie.where({ :id => a_character.movie_id.to_i })[0].title, 
        :year => Movie.where({ :id => a_character.movie_id.to_i })[0].year, 
        :director => Director.where({ :id => Movie.where({ :id => a_character.movie_id })[0].director_id.to_i })[0].name
      }
    end

    pp(@characters)

    render({ :template => "misc_templates/actor"})
  end

end
