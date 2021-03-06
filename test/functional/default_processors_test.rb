require File.join(File.dirname(__FILE__), '..', 'test_helper')

class DefaultProcessorsTest < Test::Unit::TestCase
  def test_png_crush_processor_with_unoptimize_png
    assert_processor_optimizes_file(ImageSqueeze::PNGCrushProcessor, 'unoptimized_png.png')
  end
  
  def test_png_crush_processor_with_optimized_png
    assert_processor_doesnt_optimize_file(ImageSqueeze::PNGCrushProcessor, 'already_optimized_png.png')
  end

  def test_optipng_processor_with_unoptimize_png
    assert_processor_optimizes_file(ImageSqueeze::OptiPNGProcessor, 'unoptimized_png.png')
  end
  
  def test_optipng_processor_with_optimized_png
    assert_processor_doesnt_optimize_file(ImageSqueeze::OptiPNGProcessor, 'already_optimized_png.png')
  end
  
  def test_jpegtran_progressive_processor_with_already_optimized
    assert_processor_doesnt_optimize_file(ImageSqueeze::JPEGTranProgressiveProcessor, 'already_optimized_jpg.jpg')
  end
  
  def test_jpegtran_progressive_processor_with_progressive_optimized
    assert_processor_optimizes_file(ImageSqueeze::JPEGTranProgressiveProcessor, 'better_as_progressive.jpg')
  end
  
  def test_jpegtran_non_progressive_processor_with_already_optimized
    assert_processor_doesnt_optimize_file(ImageSqueeze::JPEGTranNonProgressiveProcessor, 'already_optimized_jpg.jpg')
  end
  
  def test_jpegtran_non_progressive_processor_with_progressive_optimized
    assert_processor_optimizes_file(ImageSqueeze::JPEGTranNonProgressiveProcessor, 'better_without_progressive.jpg')
  end
  
  def test_gifsicle_processor_with_unoptimized_animated_gif
    assert_processor_optimizes_file(ImageSqueeze::GifsicleProcessor, 'unoptimized_animated_gif.gif')
  end
  
  def test_gifsicle_processor_with_already_optimized_animated_gif
    assert_processor_doesnt_optimize_file(ImageSqueeze::GifsicleProcessor, 'already_optimized_animated_gif.gif')
  end
  
  def test_gif_to_png_processor_with_unoptimized_gif
    assert_processor_optimizes_file(ImageSqueeze::GIFToPNGProcessor, 'unoptimized_gif.gif')
  end
  
  def test_png_to_progressive_jpg
    assert_processor_optimizes_file(ImageSqueeze::PNGToProgressiveJPEGProcessor, 'png_without_transparency.png')
  end

  def test_png_to_progressive_jpg_doesnt_convert_png_with_transparency
    assert_processor_doesnt_optimize_file(ImageSqueeze::PNGToProgressiveJPEGProcessor, 'png_with_transparency.png')
  end

  def test_png_to_non_progressive_jpg
    assert_processor_optimizes_file(ImageSqueeze::PNGToNonProgressiveJPEGProcessor, 'png_without_transparency.png')
  end
  
  def test_png_to_non_progressive_jpg_doesnt_convert_png_with_transparency
    assert_processor_doesnt_optimize_file(ImageSqueeze::PNGToNonProgressiveJPEGProcessor, 'png_with_transparency.png')
  end


  private
  def assert_processor_optimizes_file(processor, file)
    squeezer = ImageSqueeze.new(:processors => [processor])
    filename = fixtures(file)
    old_size = File.size(filename)
    new_filename = squeezer.squeeze!(filename)
    assert new_filename && File.size(new_filename) < old_size, "New file should be smaller than original of #{old_size}"
  end
  
  def assert_processor_doesnt_optimize_file(processor, file)
    squeezer = ImageSqueeze.new(:processors => [processor])
    filename = fixtures(file)
    old_size = File.size(filename)
    new_filename = squeezer.squeeze!(filename)
    new_file_size = File.size(new_filename) if new_filename
    assert new_filename.nil?, "New file size of #{new_file_size} should be at least as big as original of #{old_size}"
  end
end