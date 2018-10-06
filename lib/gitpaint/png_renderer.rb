require 'chunky_png'

module Gitpaint
  class PNGRenderer < Array
    def initialize png_path 
      png = ChunkyPNG::Image.from_file png_path

      png.height.times do |i| 
        self.push(
	  png.row(i).to_a.map do |p|
            self.class.scale self.class.invert self.class.magnitude p
	  end
       	)
      end
    end

    def self.magnitude value 
      value / 256 ** 3
    end

    def self.invert value 
      256 - value
    end

    def self.scale value
      value / (256 / 5)
    end
  end
end
