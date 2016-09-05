import React from 'react';
import ReactDOM from 'react-dom';
import { Link } from 'react-router';

import './Page.css';

export default function(props) {
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
                <li><Link activeClassName="active" to="/newest">Newest</Link></li>
                <li><Link activeClassName="active" to="/top">Top</Link></li>
                <li><Link activeClassName="active" to="/random">Random</Link></li>
            </ul>
            <div className="Page-content">
                {props.children}
            </div>
        </div>
    );
}
