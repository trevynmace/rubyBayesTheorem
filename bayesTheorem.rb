def sum(category, quality, sampleSpace)
  sum = 0
  sampleSpace.each do |categoryKey, categoryHash|
    if category == categoryKey
      categoryHash.each do |qualityKey, qualityValue|
        if (quality == qualityKey) || (quality == '')
          sum += qualityValue[0]
        end
      end
    elsif category == ''
      categoryHash.each do |qualityKey, qualityValue|
        if quality == ''
          sum += qualityValue[0]
        end
      end
    end
  end
  return sum.to_f
end

def probability(category, sampleSpace)
  return sum(category, "", sampleSpace) / sum("", "", sampleSpace)
end

def independentProbability(category, quality, sampleSpace)
  return sum(category, quality, sampleSpace) / sum("", "", sampleSpace)
end

def conditionalProbability(category, quality, sampleSpace)
  return independentProbability(category, quality, sampleSpace) / probability(category, sampleSpace)
end

def bayes(category, quality, sampleSpace)
  sum = 0
  sampleSpace.each do |key, value|
    sum += probability(key, sampleSpace) * conditionalProbability(key, quality, sampleSpace)
  end
  return probability(category, sampleSpace) * conditionalProbability(category, quality, sampleSpace) / sum
end

frenchGuySampleSpace = {
    "France" => {
        "Boy" => [10],
        "Girl" => [10]
    },
    "UK" => {
        "Boy" => [10],
        "Girl" => [20]
    },
    "Canada" => {
        "Boy" => [10],
        "Girl" => [30]
    }
}

puts "French Guy"
puts frenchGuySampleSpace
puts "Probability of being French: " + ("%3.2f" % (probability("France", frenchGuySampleSpace) * 100)).to_s + "%"
puts "Probability of being a French boy: " + ("%3.2f" % (independentProbability("France", "Boy", frenchGuySampleSpace) * 100)).to_s + "%"
puts "Probability of being a boy assuming a person is French: " + ("%3.2f" % (conditionalProbability("France", "Boy", frenchGuySampleSpace) * 100)).to_s + "%"
puts "Probability of being French assuming a person is a boy: " + ("%3.2f" % (bayes("France", "Boy", frenchGuySampleSpace) * 100)).to_s + "%"

stockSampleSpace = {
    "Grows" => {
        "Up" => [0.56],
        "Down" => [0.14]
    },
    "Slows" => {
        "Up" => [0.09],
        "Down" => [0.21]
    }
}

puts "\n\n"
puts "Economic Growth and Slowing"
puts stockSampleSpace
puts "Probability the economy is growing when stock is up: " + ("%3.2f" % (bayes("Grows", "Up", stockSampleSpace) * 100)).to_s + "%"
puts "Probability the economy is growing when stock is down: " + ("%3.2f" % (bayes("Grows", "Down", stockSampleSpace) * 100)).to_s + "%"
puts "Probability the economy is slowing when stock is up: " + ("%3.2f" % (bayes("Slows", "Up", stockSampleSpace) * 100)).to_s + "%"
puts "Probability the economy is slowing when stock is down: " + ("%3.2f" % (bayes("Slows", "Down", stockSampleSpace) * 100)).to_s + "%"