fun next() = readLine() ?: error("標準入力が null になっています")
fun nextInt() = next().toInt()
fun nextLong() = next().toLong()
fun nextDouble() = next().toDouble()
fun nextList() = next().split(" ")
fun nextIntList() = nextList().map{ it.toInt() }
fun nextLongList() = nextList().map{ it.toLong() }
fun nextDoubleList() = nextList().map{ it.toDouble() }

/**
 * Iterable<T> の最小要素を取得 (kotlin 1.3.71 には無いため用意)
 */
fun <T : Comparable<T>> Iterable<T>.minOf(): T {
    val iterator = this.iterator()
    if (!iterator.hasNext()) throw NoSuchElementException()
    var minValue = iterator.next()
    while (iterator.hasNext()) {
        val v = iterator.next()
        if (minValue > v) {
            minValue = v
        }
    }
    return minValue
}

/**
 * Iterable<T> の最大要素を取得 (kotlin 1.3.71 には無いため用意)
 */
fun <T : Comparable<T>> Iterable<T>.maxOf(): T {
    val iterator = this.iterator()
    if (!iterator.hasNext()) throw NoSuchElementException()
    var maxValue = iterator.next()
    while (iterator.hasNext()) {
        val v = iterator.next()
        if (maxValue < v) {
            maxValue = v
        }
    }
    return maxValue
}
