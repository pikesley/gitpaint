module Gitpaint
  describe PNGRenderer do 
    let(:subject) { 
      described_class.new File.join(File.dirname(__FILE__), 'fixtures/test.png')
    }

    it 'gets the magnitude' do 
      expect(PNGRenderer.magnitude 4294967295).to eq 255
      expect(PNGRenderer.magnitude 16777216).to eq 1
      expect(PNGRenderer.magnitude 255).to eq 0
    end

    it 'inverts the value' do 
      expect(PNGRenderer.invert 0).to eq 256
      expect(PNGRenderer.invert 64).to eq 192
      expect(PNGRenderer.invert 128).to eq 128
      expect(PNGRenderer.invert 256).to eq 0
    end

    it 'scales the value' do 
      expect(PNGRenderer.scale 256).to eq 5
      expect(PNGRenderer.scale 0).to eq 0
    end

    it 'has the correct pixels' do 
      expect(subject).to eq [
        [2, 2, 4, 5, 5, 5, 5, 5, 4, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 1, 3, 2, 2, 2, 1, 4, 5, 5, 4, 4, 5, 5, 5, 5, 5, 4, 4, 5, 5, 5, 5, 4, 3, 2, 3, 2, 2], 
	[1, 3, 2, 4, 5, 5, 5, 5, 5, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 2, 1, 2, 2, 1, 2, 4, 5, 5, 2, 4, 5, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 4, 3, 4, 4, 4, 3], 
	[1, 1, 2, 2, 4, 5, 5, 5, 5, 4, 3, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 5, 5, 5, 4, 2, 2, 2, 2, 2, 5, 4, 2, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 3, 4, 5, 5, 5, 5], 
	[4, 2, 1, 2, 2, 4, 5, 5, 5, 5, 3, 4, 5, 5, 5, 5, 5, 5, 5, 4, 1, 2, 4, 5, 5, 4, 3, 2, 3, 2, 4, 2, 0, 2, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 4, 5, 5, 5, 5, 5], 
	[5, 4, 3, 2, 1, 2, 5, 5, 5, 5, 4, 3, 4, 5, 5, 5, 5, 5, 5, 5, 3, 0, 1, 3, 4, 4, 2, 1, 2, 4, 4, 1, 1, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 5, 5, 5, 5, 5, 5], 
	[5, 5, 4, 3, 2, 1, 4, 5, 5, 5, 5, 4, 3, 5, 5, 5, 5, 5, 5, 5, 5, 4, 2, 1, 4, 4, 2, 1, 1, 2, 4, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5], 
	[5, 5, 5, 4, 2, 1, 4, 4, 5, 5, 5, 5, 4, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 4, 2, 1, 4, 5, 5, 5, 5, 5, 5, 5, 3, 3, 3, 3, 2, 3, 3, 5, 5, 5, 5, 5, 5, 5]
      ]
    end
  end
end
