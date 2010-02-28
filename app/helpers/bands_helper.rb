module BandsHelper
  
  def generate_one_random_band_picture(band)
    firstRandomNumber = rand(band.bandpictures.count)
    return firstRandomNumber
  end
  
  def CalulateStartingPhotoNumber(page)
    if(page.to_i == 0 || page.to_i == 1) then 
      return 1
    else  
      return (page.to_i - 1) * 12 + 1
    end
  end
  
  def CalculateEndingPhotoNumber(page, totalPictures)
    if(page.to_i == 0 || page.to_i == 1) then 
      if(totalPictures < 12) then
        return totalPictures
      else
        return 12
      end
    else  
      return ((page.to_i - 1) * 12) + 12
    end
  end
  
end