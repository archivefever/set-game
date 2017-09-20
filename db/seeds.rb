# shapes: squiggle, oval, diamond
# shading: solid, hatched, empty
# colors: red, green, purple
# number: 1, 2, 3

colors = ["red", "green", "purple"]
shadings = ["solid", "hatched", "empty"]
shapes = ["squiggle", "oval", "diamond"]
numbers = [1, 2, 3]


colors.each do |color|
  shadings.each do |shading|
    shapes.each do |shape|
      numbers.each do |number|
        Card.create!(color: color, shading: shading, shape: shape, number: number)
      end
    end
  end
end


