import React from 'react';
import ReactDOM from 'react-dom';

import './Page.css';

import Quote from './Quote';
import moment from 'moment';

export default React.createClass({
    render: function () {
        return (
            <div className="Page">
                <pre className="Page-logo">
{`
██████╗ ██████╗ ██████╗
██╔═══██╗██╔══██╗██╔══██╗
██║   ██║██║  ██║██████╔╝
██║▄▄ ██║██║  ██║██╔══██╗
╚██████╔╝██████╔╝██████╔╝
╚══▀▀═╝ ╚═════╝ ╚═════╝`}
                </pre>
                <div className="Page-content">
                    <Quote id={157} content="<Silent-Shadow> since it's a termianl\n<Silent-Shadow> tmeirnal\n<Silent-Shadow> temrinal\n<Silent-Shadow> temrinal\n<Silent-Shadow> ...\n<Silent-Shadow> termnial\n<Silent-Shadow> :)\n<Silent-Shadow> damnit\n<Silent-Shadow> terminal\n<Silent-Shadow> GHA\n<Silent-Shadow> HA*\n"
                        createdDate={moment()} upvotes={256} downvotes={358} />
                    <Quote id={111} content="// Zeus is trying to install Ubuntu.\n<Zeus> Would windows 95 have enough memory?\n<Zeus> my ME OS is f'ed up anyways\n<nazgjunk> wtf.\n<Stoney> Zeus, it has nothing to do with windows\n<nazgjunk> your operating system doesn't have memory\n<nazgjunk> your computer does\n<metalslug> ...\n<Zeus> how can i fix that?"
                        createdDate={moment()} upvotes={254} downvotes={334} />
                    <Quote id={15874} content="<case> if it's got a hole, it's hot\n<missingRemote> u might like me then"
                        createdDate={moment()} upvotes={1} downvotes={1} />
                    <Quote id={4030} content="<pookleblinky> It is that time of night when we forget who we are and why we are here.\n<pookleblinky> And where our pants have gone"
                        createdDate={moment()} upvotes={1} downvotes={1} />
                </div>
            </div>
        );
    }
});
