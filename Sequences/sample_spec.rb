describe 'expect(series' do
  it 'handles fibonacci expect(series' do
    expect(series('fibonacci', 1)).to eq 1
    expect(series('fibonacci', 2)).to eq 1
    expect(series('fibonacci', 20)).to eq 6765
  end

  it 'handles lucas expect(series' do
    expect(series('lucas', 1)).to eq 2
    expect(series('lucas', 2)).to eq 1
    expect(series('lucas', 3)).to eq 3
    expect(series('lucas', 4)).to eq 4
    expect(series('lucas', 15)).to eq 843
  end

  it 'handles summed expect(series' do
    expect(series('summed', 1)).to eq 3
    expect(series('summed', 15)).to eq 1453
  end
end