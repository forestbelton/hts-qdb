import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, hashHistory } from 'react-router';

import Page from './lib/components/Page';
import Quote from './lib/components/Quote';

import moment from 'moment';

const quotes = [
    <Quote id={157} createdDate={moment()} upvotes={256} downvotes={358}
        content="<Silent-Shadow> since it's a termianl\n<Silent-Shadow> tmeirnal\n<Silent-Shadow> temrinal\n<Silent-Shadow> temrinal\n<Silent-Shadow> ...\n<Silent-Shadow> termnial\n<Silent-Shadow> :)\n<Silent-Shadow> damnit\n<Silent-Shadow> terminal\n<Silent-Shadow> GHA\n<Silent-Shadow> HA*" />,
    <Quote id={111} content="// Zeus is trying to install Ubuntu.\n<Zeus> Would windows 95 have enough memory?\n<Zeus> my ME OS is f'ed up anyways\n<nazgjunk> wtf.\n<Stoney> Zeus, it has nothing to do with windows\n<nazgjunk> your operating system doesn't have memory\n<nazgjunk> your computer does\n<metalslug> ...\n<Zeus> how can i fix that?"
        createdDate={moment()} upvotes={254} downvotes={334} />
];

ReactDOM.render(
    <Router history={hashHistory}>
        <Route path="/" component={Page}>
            <Route path="/newest" component={null} />
            <Route path="/top" component={null} />
            <Route path="/random" component={null} />
            <Route path="/new" component={null} />
        </Route>
    </Router>,
    document.getElementById('root')
);
