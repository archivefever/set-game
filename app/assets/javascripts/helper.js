var Util = function() {
};

Util.getCombinations = function(array, size, start, initialStuff, output) {
    if (initialStuff.length >= size) {
        output.push(initialStuff);
    } else {
        var i;

        for (i = start; i < array.length; ++i) {
      Util.getCombinations(array, size, i + 1, initialStuff.concat(array[i]), output);
        }
    }
};

Util.getAllPossibleCombinations = function(array, size, output) {
    Util.getCombinations(array, size, 0, [], output);
};