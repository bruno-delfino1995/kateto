package main

import (
	"context"
	"os"

	"github.com/charmbracelet/fang"
	"github.com/spf13/cobra"
)

func main() {
	cmd := &cobra.Command{
		Use:   "kateto",
		Short: "Another Kubernetes Templating Tool",
	}

	if err := fang.Execute(context.Background(), cmd); err != nil {
		os.Exit(1)
	}
}
