class ImageSqueeze
  class GIFToPNGProcessor < Processor
    def self.input_type
      GIF
    end
    
    def self.output_extension
      '.png'
    end
    
    def self.squeeze(filename, output_filename)
      intermediate_tmp_filename = "%s-%s" % [output_filename, '.tmp']
      
      system("convert #{filename} PNG:#{intermediate_tmp_filename} 2> /dev/null")
      response = PNGCrushProcessor.squeeze(intermediate_tmp_filename, output_filename) # run it through PNGCrush afterwards
      
      FileUtils.rm(intermediate_tmp_filename) # clean up after ourselves
      
      response
    end
  end
end