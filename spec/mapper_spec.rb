module Gitpaint
  context 'map data to commits' do
    context 'pad data' do
      it 'pads an empty row' do
        expect(Gitpaint.pad_row [1, 0, 1]).to eq (
          [1, 0, 1] + [0] * 49
        )
      end

      it 'adds blank rows' do
        grid = Gitpaint.pad_grid [[1, 0, 1, 0, 1, 1], [1]]
        expect(grid[0]).to eq [1, 0, 1, 0, 1, 1] + [0] * 46
        expect(grid[6]).to eq [0] * 52
      end
    end

    context 'turn data into dates' do
      it 'handles a single datapoint' do
        Timecop.freeze '2018-09-22' do
          data = [[1]]
          expect(Gitpaint.data_to_dates data).to eq (
            {
              '2017-09-17' => 1
            }
          )
        end
      end

      it 'handles 2 datapoints' do
        Timecop.freeze '2018-09-22' do
          data = [[1, 1]]
          expect(Gitpaint.data_to_dates data).to eq (
            {
              '2017-09-17' => 1,
              '2017-09-24' => 1
            }
          )
        end
      end

      it 'handles richer data' do
        Timecop.freeze '1974-06-15' do
          data = [[0, 2, 2], [], [0, 1]]
          expect(Gitpaint.data_to_dates data).to eq (
            {
              '1973-06-17' => 2, 
              '1973-06-19' => 1,
              '1973-06-24' => 2
            }
          )
        end
      end
    end
  end
end
