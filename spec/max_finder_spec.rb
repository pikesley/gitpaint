module Gitpaint
  describe 'max_finder' do
    it 'finds the maximum when 3', :vcr do
      expect(Gitpaint.max_finder 'towers-of-hanoi').to eq 3
    end

    it 'finds the maximum when 6', :vcr do
      expect(Gitpaint.max_finder 'towers-of-hanoi').to eq 6
    end
  end
end
