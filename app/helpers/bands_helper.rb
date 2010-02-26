module BandsHelper
  
  def generate_one_random_band_picture(band)
    firstRandomNumber = rand(band.bandpictures.count)
    return firstRandomNumber
  end
  
end