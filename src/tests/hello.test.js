import React from "react";
import { render, screen } from "@testing-library/react";
import '@testing-library/jest-dom';

// Simple Hello component for demo
function Hello({ name }) {
  return <h1>Hello, {name}!</h1>;
}

test("renders greeting with name", () => {
  render(<Hello name="World" />);
  
  // Check if the text "Hello, World!" exists in the document
  const greetingElement = screen.getByText("Hello, World!");
  expect(greetingElement).toBeInTheDocument();
});
