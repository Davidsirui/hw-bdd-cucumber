class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # sort = params[:sort] || session[:sort]
    # case sort
    # when 'title'
    #   ordering,@title_header = {:title => :asc}, 'bg-warning hilite'
    # when 'release_date'
    #   ordering,@date_header = {:release_date => :asc}, 'bg-warning hilite'
    # end
    # @all_ratings = Movie.all_ratings
    # @selected_ratings = params[:ratings] || session[:ratings] || {}

    # if @selected_ratings == {}
    #   @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    # end

    # if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
    #   session[:sort] = sort
    #   session[:ratings] = @selected_ratings
    #   redirect_to :sort => sort, :ratings => @selected_ratings and return
    # end
    # @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
    
    #TODO: The code below is transfer from my HW2
    @all_ratings = Movie.all_ratings

    sort = params[:sort] || session[:sort]
    @ordering = session[:sort]
    if sort == 'title'
      @title_cls = 'hilite'
    elsif sort == 'release_date'
      @release_cls = 'hilite'
    end
    
    set_rate_to_show()
                      
                      
    
    if !params[:ratings].nil?
      session[:ratings] = params[:ratings]
      flash.keep
    else
        if !session[:sort].nil?
          flash.keep
          redirect_to sort => sort, ratings: @ratings_to_show
        else
          flash.keep
          redirect_to ratings: @ratings_to_show
        end
    end
    

       
    @movies = Movie.with_ratings(@ratings_to_show.keys).order(@ordering)
    
    session[:sort] = sort
    session[:ratings] = @ratings_to_show
  end

  
  def set_rate_to_show
    @ratings_to_show = params[:ratings] || session[:ratings] \
      || Hash[@all_ratings.map { |r| [r, 1] }]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  private
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

end
