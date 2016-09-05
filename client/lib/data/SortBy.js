export default class SortBy {
    constructor(name) {
        this.name = name;
    }

    getName() {
        return this.name;
    }
}

SortBy.NEWEST = new SortBy('Newest');
SortBy.TOP    = new SortBy('Top');
SortBy.RANDOM = new SortBy('Random');
