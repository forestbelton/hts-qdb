import React from 'react';
import ReactDOM from 'react-dom';

import './Page.css';

import Quote from './Quote';
import moment from 'moment';

const Page = function(props) {
    const quotes = props.quotes
        .map((quote, i) => <div key={i}>{quote}</div>);

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
            <ul className="Page-nav">
                <li>Newest</li>
                <li>Top</li>
                <li>Random</li>
            </ul>
            <div className="Page-content">
                {quotes}
            </div>
        </div>
    );
};

Page.propTypes = {
    quotes: React.PropTypes.arrayOf(Quote).isRequired
};

export default Page;
