import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, hashHistory, IndexRedirect } from 'react-router';

import Page from './lib/components/Page';
import Quotes from './lib/components/Quotes';
import SortBy from './lib/data/SortBy';

const NewestQuotes = () => <Quotes sortBy={SortBy.NEWEST} />;
const TopQuotes    = () => <Quotes sortBy={SortBy.TOP} />;
const RandomQuotes = () => <Quotes sortBy={SortBy.RANDOM} />;

ReactDOM.render(
    <Router history={hashHistory}>
        <Route path="/" component={Page}>
            <IndexRedirect to="/newest" />
            <Route path="/newest" component={NewestQuotes} />
            <Route path="/top" component={TopQuotes} />
            <Route path="/random" component={RandomQuotes} />
            <Route path="/new" component={null} />
        </Route>
    </Router>,
    document.getElementById('root')
);
